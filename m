Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVIEGdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVIEGdD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 02:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVIEGdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 02:33:01 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:13083 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932251AbVIEGdA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 02:33:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=seV42xmjNIgFzKXOXcbEUoqdeZycgBaaOcLetmAcMitaO85mZhC34Hx8sKHLXv02uh2IAaOLrHOKXnEMYo2eI46rbrMzqb/bm2oQrPI7kiHO1wjrrgl2slK3Wu/jc0gj6BfY8dfm4Yp+Ap/TGhuTDGN10O6KRksOfEutzs7wPQI=
Message-ID: <84144f02050904233274d45230@mail.gmail.com>
Date: Mon, 5 Sep 2005 09:32:59 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: David Teigland <teigland@redhat.com>
Subject: Re: GFS, what's remaining
Cc: Arjan van de Ven <arjan@infradead.org>, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
In-Reply-To: <20050905054348.GC11337@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050901104620.GA22482@redhat.com>
	 <1125574523.5025.10.camel@laptopd505.fenrus.org>
	 <20050905054348.GC11337@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 01:35:23PM +0200, Arjan van de Ven wrote:
> > +void gfs2_glock_hold(struct gfs2_glock *gl)
> > +{
> > +     glock_hold(gl);
> > +}
> >
> > eh why?

On 9/5/05, David Teigland <teigland@redhat.com> wrote:
> You removed the comment stating exactly why, see below.  If that's not a
> accepted technique in the kernel, say so and I'll be happy to change it
> here and elsewhere.

Is there a reason why users of gfs2_glock_hold() cannot use
glock_hold() directly?

                            Pekka
