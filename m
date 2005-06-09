Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVFIQO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVFIQO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 12:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVFIQO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 12:14:56 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:21056 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262391AbVFIQOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 12:14:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OUjVokry4xqeiOJy+IY1zWSxL6Vk4zZP+uYCvMTeoRztO6+m2qvdgc2FFQwDcTx7/OLoOdpWI59gWF19AYxa4BHj+v6aYTKMDiDer7rZwRexalK0iE+8Wp1gaIHQmQHMMTQtc8fFRxT9rljnuByiKBLIvYm3oEkGFWQ8jJt22pY=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Pekka Enberg <penberg@gmail.com>
Subject: Re: [RFC] SPI core
Date: Thu, 9 Jun 2005 20:19:50 +0400
User-Agent: KMail/1.7.2
Cc: dpervushin@ru.mvista.com, linux-kernel@vger.kernel.org
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru> <84144f020506090533b00b823@mail.gmail.com>
In-Reply-To: <84144f020506090533b00b823@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506092019.50210.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 June 2005 16:33, Pekka Enberg wrote:
> On 5/31/05, dmitry pervushin <dpervushin@ru.mvista.com> wrote:
> > +EXPORT_SYMBOL(spi_add_adapter);
> > +EXPORT_SYMBOL(spi_del_adapter);
> > +EXPORT_SYMBOL(spi_get_adapter);
> > +EXPORT_SYMBOL(spi_put_adapter);
> > +
> > +EXPORT_SYMBOL(spi_add_driver);
> > +EXPORT_SYMBOL(spi_del_driver);
> > +EXPORT_SYMBOL(spi_get_driver);
> > +EXPORT_SYMBOL(spi_put_driver);
> > +
> > +EXPORT_SYMBOL(spi_attach_client);
> > +EXPORT_SYMBOL(spi_detach_client);
> > +
> > +EXPORT_SYMBOL(spi_transfer);
> > +EXPORT_SYMBOL(spi_write);
> > +EXPORT_SYMBOL(spi_read);
> 
> Preferred location for EXPORT_SYMBOLs is immediately after the function
> definition.

New files can choose any style.
