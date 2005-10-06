Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVJFRZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVJFRZb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVJFRZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:25:31 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:43271 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751245AbVJFRZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:25:31 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1128618447.8396.39.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Thu, 06 Oct 2005 13:07:27 -0400)
Subject: Re: [RFC] atomic create+open
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu> <1128618447.8396.39.camel@lade.trondhjem.org>
Message-Id: <E1ENZTJ-0003Mm-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 06 Oct 2005 19:23:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, but what value does an extra function call add then when you already
> have lookup intents?

Just to provide a proper interface, and not have to extend open
intents further.

Earlier you said, that intents are meant to be optional, so this
atomicity requirement is getting further from the "intent" concept.

Miklos
