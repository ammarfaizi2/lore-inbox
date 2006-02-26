Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWBZUlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWBZUlj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 15:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWBZUlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 15:41:39 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:45704 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751288AbWBZUli convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 15:41:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BK+66ABbcDQY4GdpuPNtJVrjURD3lyyDTw051dk9x5ZpuOGNVCeIBkjHUZ48q1gn3WQzYYFfL29NomDCyt3eIUlmDfsIDAh42pEkKvQ5aorRGbm1drm3isP6NpSLCWyQ9L2vHzg9xGuAT37ov3RIX3d3Ri4G+snwVmdSqDTWq4o=
Message-ID: <9a8748490602261241j6e55cf45g5c4b6ddd211f85c3@mail.gmail.com>
Date: Sun, 26 Feb 2006 21:41:37 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "James Bottomley" <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] silence gcc warning about possibly uninitialized use of variable in scsi_scan
Cc: linux-kernel@vger.kernel.org, "Eric Youngdale" <eric@andante.org>,
       linux-scsi@vger.kernel.org
In-Reply-To: <1140981714.3692.12.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261639.15657.jesper.juhl@gmail.com>
	 <1140978084.3692.6.camel@mulgrave.il.steeleye.com>
	 <9a8748490602261023j46eb39f2peaa080d737fee5e1@mail.gmail.com>
	 <1140980377.3692.9.camel@mulgrave.il.steeleye.com>
	 <9a8748490602261101q39f4cf8eqabe0143921389ce6@mail.gmail.com>
	 <1140981714.3692.12.camel@mulgrave.il.steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, James Bottomley <James.Bottomley@steeleye.com> wrote:
> On Sun, 2006-02-26 at 20:01 +0100, Jesper Juhl wrote:
> > Hmm, it's quite reproducible and the gcc 3.4.5 I have here is not
> > patched by the distribution (Slackware). If you want I can send you
> > the .config that results in the warning..
>
> I really don't think it's a config issue.  scsi_probe_lun() is always
> compiled in if CONFIG_SCSI is set.  I think you have a compiler problem.
>

I must admit I think the compiler is OK.
I have two different boxes with gcc 3.4.5 and they both give the same
warning (not to mention that that gcc builds everything I've thrown at
it correctly).
But nevermind, it's just a silly little warning - just leave it be.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
