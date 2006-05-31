Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbWEaVXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbWEaVXX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWEaVXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:23:23 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:2570 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965138AbWEaVXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:23:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XxyuCTUFqluwWyWD+VhUOklhXP171YLdPrUJAdZtpNphyhKxb3O1Abw/2Zosn8IXaFsKL9avz0ArxwJgVw72y2mOeI0dSUllNX+YWLGEeofu1LZw0CkUQZhSP2966VtwSFmlxnmOKLo4shJ2eOPoFVcLBOE3IJjZtuCdY1kEkR8=
Message-ID: <9e4733910605311423o14858c8fi8679b51ce2f52bca@mail.gmail.com>
Date: Wed, 31 May 2006 17:23:21 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       "Ondrej Zajicek" <santiago@mail.cz>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
In-Reply-To: <E1FlXMw-0002Md-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>
	 <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>
	 <20060530223513.GA32267@localhost.localdomain>
	 <447CD367.5050606@gmail.com>
	 <Pine.LNX.4.62.0605312033260.16745@pademelon.sonytel.be>
	 <9e4733910605311257m19450bbai4c3ae6fdc7909a4@mail.gmail.com>
	 <E1FlXMw-0002Md-00@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/06, Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
>
> > Moving back to a vgafb with text mode support in fbcon would be one
> > way to eliminate a few of the way too many graphics drivers. I don't
> > see any real downside side to doing this, does any one else see any
> > problems?
>
> Just to check what you mean by "text mode" - is this vga mode 3, or
> a graphical vga mode with text drawn in it? vga16fb doesn't work on all
> hardware that vgacon works on, much to my continued misery.

Text mode meaning the non-bitmap display modes where the video
hardware generates the glyphs.

>
> --
> Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
>


-- 
Jon Smirl
jonsmirl@gmail.com
