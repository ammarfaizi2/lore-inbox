Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbUKCVo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbUKCVo6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUKCVo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:44:57 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:20360 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261898AbUKCVlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:41:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ooQCGw/jpDCIBQjvMvI2Z8lgC3RccTL2FnM+P11/HcYg783t3r/SNLfWUVg8EG0yWnvHu4ZyXoejaXGt1HLlWT1OKHuKiG94qFln1dyz/kfJwzm8X0E78pY9G5Vb724j+AjX6/MD2PR7xm5EfhvgvDot4hfFqz0O0W+htAs4kzE=
Message-ID: <2764738e04110313402159c534@mail.gmail.com>
Date: Thu, 4 Nov 2004 03:10:55 +0530
From: Dhaval Vasa <dhavalvasa@gmail.com>
Reply-To: Dhaval Vasa <dhavalvasa@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Installing software on a knoppix CD
Cc: Sai Prathap <saiprathap@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <418940AA.7000809@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <69cfd1b80411031106663a1cc8@mail.gmail.com>
	 <418940AA.7000809@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Customizing knoppix is fairly easy.  You should be familiar with few
commands like mkisofs, apt-get, etc.

Further information can be obtained from following url:

http://www.knoppix.net/docs/index.php/KnoppixRemasteringHowto

Alternatively, you may install knoppix on a harddisk and subsequently customize.

I hope this helps.

Dhaval



On Wed, 03 Nov 2004 15:33:46 -0500, Bill Davidsen <davidsen@tmr.com> wrote:
> Sai Prathap wrote:
> > Hi,
> >
> > I have a question regarding knoppix. If we boot from a knoppix CD, Is
> > it possible to get any software installed on it ? Because, whenever I
> > try to install something  it says its not writable. Please advice.
> 
> *If* there is room on the CD, you can add things to the image and burn a
> new CD. The "right" method is to mount the CD and copy everything into a
> directory, add the new material, run mkisofs with the right boot options
> to make a bootable image, and burn the image.
> 
> If you are heavily into burning CDs, you *MIGHT* be able to extract the
> ISO image, reburn it with the cdrecord -multi option, and then add your
> own stuff in a second session. I haven't tried this, and if you aren't
> familiar with burning multisession CDs it's eather a learning experience
> or a good thing to avoid.
> 
> Check first to see if there's any room on the CD for more stuff!
> 
> --
>     -bill davidsen (davidsen@tmr.com)
> "The secret to procrastination is to put things off until the
>   last possible moment - but no longer"  -me
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
