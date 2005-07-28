Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVG1Kdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVG1Kdl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 06:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVG1Kdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 06:33:41 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:21050 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261367AbVG1Kdk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 06:33:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RkRVOrgtg8zFRVCF3z6tgzLQy15TAXczbKpBrNmuKNZ0PSQ3CsiySWxYkSyrYQcWNcTevtOh0YermwJXA/xK/uwqwBdQeEOYeYX+6jYon5ETerdWvadouGhQKnUAQqMUcKiaKtobRgXv1Ewl26+23uBKhq6xcTfu80OF+UNx6zE=
Message-ID: <c0140e760507280333174f7e7d@mail.gmail.com>
Date: Thu, 28 Jul 2005 12:33:38 +0200
From: cengizkirli <cengizkirli@gmail.com>
Reply-To: cengizkirli <cengizkirli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Mouse Freezes in Xorg on ASUS P4C800 Deluxe
In-Reply-To: <c0140e7605072802236f4c3b26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c0140e76050723082730836e7b@mail.gmail.com>
	 <9a8748490507230836584948c6@mail.gmail.com>
	 <c0140e7605072308424eb60d57@mail.gmail.com>
	 <c0140e7605072312377b348743@mail.gmail.com>
	 <c0140e7605072802236f4c3b26@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/05, cengizkirli <cengizkirli@gmail.com> wrote:
> It seems to work after comparing my .config with Andreas Baer's and also
> setting USB Support to "built-in" and not "module". Somehow the modules
> are unloaded or whatever. It seems to work now. Hopefully it will last...
> 

now I know why I set USB to "module": with USB "built-in" it does not reboot.
on Debian it just prints "Rebooting..." and that's all that happens. hmm, maybe
ACPI related, though with 2.6.13-rc3-mm2 I don't get the "executable code
found" ACPI warnings anymore but who knows.
