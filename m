Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVEQQHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVEQQHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVEQQF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:05:27 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:5732 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261751AbVEQP5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:57:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from;
        b=T+RSDl01CyCtuJjv0XFHVroiasQZN2p+kgyV1ONYyOOoPRk4qUwvQKlQzO8LmTjwWeFVaIdjt0HZkENZN3JAdrA0gA4OnVFPToV/DFmjn2hXzwCmQjSdjJaS2r7YkNDAO1rqDUnvVbo8i6A80DmXBE1ZE6xyCTflMqyhPG4VvOU=
Date: Tue, 17 May 2005 17:57:31 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, dino@in.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050517155731.GA9590@gmail.com>
References: <20050516085832.GA9558@gmail.com> <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org> <1116340465.4989.2.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1116340465.4989.2.camel@mulgrave>
User-Agent: Mutt/1.5.6i
From: =?iso-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 09:34:25AM -0500, James Bottomley wrote:

> Actually, this isn't a me too.  The previous one looks like some strange
> DV failure.  This is a problem with the initial inquiry.  What's the
> device at target 15?

On this controler I have :

Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDRS-39130D      Rev: DC1B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: SEAGATE  Model: ST336706LW       Rev: 0108
  Type:   Direct-Access                    ANSI SCSI revision: 03

Should I change anything in the BIOS ?

Thank you, and please keep CC to me as I am not on this ml :-)
-- 
	Grégoire Favre
