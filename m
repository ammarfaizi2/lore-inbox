Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbVKVO6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbVKVO6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbVKVO6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:58:09 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:23979 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964956AbVKVO6I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:58:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=He3P3eZDcppwnnmY88bqJcwu6zhWt9bCrsiL3+51czVsoQTzIrJeQepSudEX8e9iIR/9bkCN7htp13F/++975+EokREl0DyWorvXFRHxAtRhnCI5ysqaOvYmKZq/ARWBhSvj3TlWBUSjpW2YqX4/vp8NEe2zJ+oPCdga7zu2CEQ=
Message-ID: <cda58cb80511220658n671bc070v@mail.gmail.com>
Date: Tue, 22 Nov 2005 15:58:07 +0100
From: Franck <vagabon.xyz@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: How can I prevent MTD to access the end of a flash device ?
In-Reply-To: <cda58cb80511070248o6d7a18bex@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cda58cb80511070248o6d7a18bex@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have two questions that I can't answer by my own. I tried to look at
FAQ and documentation on MTD website but found no answer.

First question is about size of flash. I have a Intel strataflash
whose size is 32MB but because of a buggy platform hardware I can't
access to the last 64KB of the flash. How can I make MTD module aware
of this new size. The restricted map size is initialized by my driver
but it doesn't seem to be used by MTD.

The second question is about the "cacheable" mapping field in map_info
structure. I looked at others drivers and this field seems to be
optional. Does this field, if set, improve flash access a lot ? Should
I set up a cacheable mapping ?

Thanks
--
               Franck
