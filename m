Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVEQQxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVEQQxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVEQQxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:53:07 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:44301 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261828AbVEQQxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:53:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from;
        b=m4/gNhWZU0VTIHlwYLBq3Yls2rzoy6Mqd3UUujzU+U3WIPRityfbR7tEsG0l9I6mfgGEIzKNPuM06ccRTKiviMdmKVIyhnMexIA/8TUXKtBr3za6C+DRtxXTe1AoyFFt4XftE69oq7aSh8nvNAn/lo3EDNzXh4kKxaf3/9Suy/g=
Date: Tue, 17 May 2005 18:52:55 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, dino@in.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050517165255.GD9590@gmail.com>
References: <20050516085832.GA9558@gmail.com> <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org> <1116340465.4989.2.camel@mulgrave> <20050517155731.GA9590@gmail.com> <1116347914.4989.24.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1116347914.4989.24.camel@mulgrave>
User-Agent: Mutt/1.5.6i
From: =?iso-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 11:38:34AM -0500, James Bottomley wrote:
> On Tue, 2005-05-17 at 17:57 +0200, Grégoire Favre wrote:
> > On this controler I have :
> > 
> > Host: scsi0 Channel: 00 Id: 00 Lun: 00
> >   Vendor: IBM      Model: DDRS-39130D      Rev: DC1B
> >   Type:   Direct-Access                    ANSI SCSI revision: 02
> > Host: scsi0 Channel: 00 Id: 15 Lun: 00
> >   Vendor: SEAGATE  Model: ST336706LW       Rev: 0108
> >   Type:   Direct-Access                    ANSI SCSI revision: 03
> 
> Erm, that doesn't square with the bug report:
> 
> >   Vendor: IBM-PSG   Model: ST39103LC     !#  Rev: B227
> >   Type:   Direct-Access                      ANSI SCSI revision: 02
> > scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
> [...]
> >   Vendor: IBM-PSG   Model: ST39103LC     !#  Rev: B227
> >   Type:   Direct-Access                      ANSI SCSI revision: 02
> > scsi0:A:1:0: Tagged Queuing enabled.  Depth 32

Well,

I just did some copy, and I didn't swap hardware ???

What does that mean ?
-- 
	Grégoire Favre
