Return-Path: <linux-kernel-owner+w=401wt.eu-S932890AbXABLzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890AbXABLzg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932893AbXABLzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:55:36 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:6930 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932890AbXABLzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:55:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=Y10qNDHs1XZZhqPm8FO8BX326s7s+TNP7n4BgM5xXhiI4LbbVrmeXbrhB4iN2Tda9aCx7+6/Zq0kdaFJEpwP5YNmTNf/j0CkcR6elwZcYmzK9dfmb2VC09+2MCmQ/eIQbv9fOggqBnJBm25CZWPnJ8mW2IPEbxl/Ql956f3vkhw=
Message-ID: <459A482C.6020809@gmail.com>
Date: Tue, 02 Jan 2007 20:55:24 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
References: <45841710.9040900@t-online.de> <4587F87C.2050100@gmail.com> <45883299.2050209@t-online.de> <45887CD8.5090100@gmail.com> <458AE5FB.7080607@t-online.de> <4591FE96.1080606@gmail.com> <459346C4.1030802@gmail.com> <45941F1E.2080808@t-online.de>
In-Reply-To: <45941F1E.2080808@t-online.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Harald Dunkel wrote:
> Hi Tejun,
> 
> After the patch was applied (using 2.6.19.1 instead of 2.6.19, hope
> you don't mind) I could play a DVD once. Unfortunately this was not
> reproducible, using the same DVD. I have attached the requested log
> files for the good and the last bad session. Hope this helps.
> 
> Which version of the SATA DVD writer have you received? The label
> on my writer says
> 
> 	H/W:A     Ver:A     September 2006

Mine is manufactured in December but other than that it's identical.
Firmware version is the same too.

> I hope I don't break any netiquette by posting large log files.
> Do I?

That's okay for me.  vger might not be too happy tho.  ;-)

Please do the following and post the result.

# strace mplayer -v dvd:// > out 2>&1

Happy new year.

-- 
tejun
