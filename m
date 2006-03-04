Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751865AbWCDQX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbWCDQX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 11:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWCDQX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 11:23:59 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:54628 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751865AbWCDQX7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 11:23:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rizH3D42wlg+Tmvmi93Ey/n+efPTjsPwh0S3p655wcZ0cDIkTyVQCm1bhh9OLdRLCj46umX/9vrF961WqzSxnmfB8fVTs8/S534PRLEeHBrUy1LbxQb8wKQmF0eF6e9EkwfLDy872jE/PTJNaZZDnyRarQAuZYnu+URpx3kR3No=
Message-ID: <a4e6962a0603040823o315ab58fn29303363dee129b3@mail.gmail.com>
Date: Sat, 4 Mar 2006 10:23:57 -0600
From: "Eric Van Hensbergen" <ericvh@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] v9fs: consolidate trans_sock into trans_fd
Cc: "Eric Van Hensbergen" <ericvh@hera.kernel.org>,
       linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
In-Reply-To: <20060303234625.21b84b61.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603022230.k22MUmm4017480@hera.kernel.org>
	 <20060303234625.21b84b61.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/06, Andrew Morton <akpm@osdl.org> wrote:
> Eric Van Hensbergen <ericvh@hera.kernel.org> wrote:
> >
> >  here is a new trans_fd.c that replaces the current
> >  trans_fd.c and trans_sock.c.  i haven't tested it but
> >  the changes are pretty trivial.
>
> I trust that second sentence is obsolete?
>

Yeah sorry -- I just cut and pasted Russ' original comments.
It has passed all of our regressions.

            -eric
