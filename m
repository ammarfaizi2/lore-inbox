Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263955AbTIIGCl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 02:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263956AbTIIGCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 02:02:41 -0400
Received: from ip-a1-37024.keycomm.it ([62.152.37.24]:25919 "EHLO
	sparc.campana.vi.it") by vger.kernel.org with ESMTP id S263955AbTIIGCk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 02:02:40 -0400
Date: Tue, 9 Sep 2003 08:02:10 +0200
From: Ottavio Campana <ottavio@campana.vi.it>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.22 compile error
Message-ID: <20030909060210.GB736@campana.vi.it>
References: <20030908084036.GA30850@campana.vi.it> <20030908131556.GB25325@DUK2.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030908131556.GB25325@DUK2.13thfloor.at>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux dirac 2.4.21-dirac 
X-Organization: Lega per la soppressione del Visual Basic
X-Homepage: http://www.campana.vi.it/ottavio/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 03:15:56PM +0200, Herbert Poetzl wrote:
> > If you need more  infos can you please cc me, for  I'm not subscribed to
> > the list?
> 
> at least the lines of bttv-if.c around 240 would be helpful,
> better put the whole tree on the web somewhere ...

static struct i2c_adapter bttv_i2c_adap_template = {	# 243
        .inc_use           = bttv_inc_use,
        .dec_use           = bttv_dec_use,
        I2C_DEVNAME("bt848"),
        .id                = I2C_HW_B_BT848,
        .client_register   = attach_inform,
};							# 249

The error is in this struct.

If    you    need     the    source,    you    can     get    it    from
http://www.campana.vi.it/ottavio/kernel-source-2.4.22-dirac.tar.bz2    .
Don't mind the  extraversion, I use it only because  I don't want debian
kernel packages to overwrite my kernel when I build my debs.

-- 
Non c'è più forza nella normalità, c'è solo monotonia.
