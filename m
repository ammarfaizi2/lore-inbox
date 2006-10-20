Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423250AbWJTXuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423250AbWJTXuW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 19:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423239AbWJTXuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 19:50:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:46129 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S2992743AbWJTXuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 19:50:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Yx+CyAIO/8mUs1r5nM4S8K7cYpj3SC5v4VBIHlVBuF9ng/23Ju13AyNKd1k7JZkng4sSRGD3iYtkPSIh8gJEktjsF2k0zN84+V+SO2Fl/2+18y4txtQ6Z6WsYJ9Xbcl18tmhio+r92QcdUyJj5fB2pWja1NMrAU7fWfxMmg4CQg=
Message-ID: <453960B3.6040006@gmail.com>
Date: Sat, 21 Oct 2006 08:50:11 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Lars_Christian_Nyg=E5?= =?ISO-8859-1?Q?rd?= 
	<lars@snart.com>
Subject: Re: Debugging I/O errors?
References: <C5C787DB-6791-462E-9907-F3A0438E6B9C@karlsbakk.net>
In-Reply-To: <C5C787DB-6791-462E-9907-F3A0438E6B9C@karlsbakk.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> Hi all
> 
> Stresstesting a SATA drive+controller, I get the error below after a 
> while. How can I find if this error is due to a controller failure, a 
> bad driver, or a drive failure?

Is there any libata/SCSI error messages in your log?

-- 
tejun
