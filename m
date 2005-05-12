Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVELMOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVELMOK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVELMOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:14:10 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:48523 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261155AbVELMOH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:14:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uybe9Z3U3LS94n6J47Q7Nr0LHzujC1kwnAT4YnGbecUVjG5x4uhYjhnbL7nm0kOEt+Ruyvd17MLb4CWNr4q9OPoPYfWEaCx4j5eVGblt3b+lqUfC6oo7aSH7slFFgV7p6f4K8I4ahbCigGffhe4fw1YhvRP29Y/D458j5DEpVBc=
Message-ID: <fe726f4e050512051439272c4e@mail.gmail.com>
Date: Thu, 12 May 2005 14:14:07 +0200
From: Carlos Martin <carlosmn@gmail.com>
Reply-To: Carlos Martin <carlosmn@gmail.com>
To: SN <talk2sumit@gmail.com>
Subject: Re: USB Mass Storage
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1458d96105051201317c49500c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <1458d96105051201317c49500c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/05, SN <talk2sumit@gmail.com> wrote:
> If I use a USB connected hard-disk (IDE), which device driver would I
> be using? I understand it is recognized as a SCSI disk. So, is it the
> SCSI driver? Or would the IDE driver be used?

 You would use the usb-storage driver which in turn uses the scsi driver.

   cmn
-- 
Carlos Martín         http://www.cmartin.tk   http://rpgscript.berlios.de

"I'll wager it's the most extraordinary thing to happen round here
since Queen Elizabeth's handmaid got hit by lightning and sprouted a
beard"
     -- T. C. Boyle, "Water Music"
