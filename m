Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWDUNwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWDUNwV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWDUNwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:52:21 -0400
Received: from web52901.mail.yahoo.com ([206.190.49.11]:24767 "HELO
	web52901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932306AbWDUNwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:52:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5uClOLY/Up6eXJl3Dgr83DM8GsklMW09q51v1N/SI27JO2+Ptnpzzo9yYecRoslmpKu6jxfDEKgMb+lBNE9umQKgrYZLzKga3yWZEKs7Yl2RG7tJ6w3qHdB+XCMwyTc6mPRP2pvynfMWU1zh//Rs545kREOUYklKBOP67doSE3w=  ;
Message-ID: <20060421135219.37720.qmail@web52901.mail.yahoo.com>
Date: Fri, 21 Apr 2006 14:52:19 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: [patch 05/22] : Fix hotplug race during device registration
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <4448DC4C.6010500@ums.usu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Alexander E. Patrakov" <patrakov@ums.usu.ru> wrote:
> Look at the old code again. This is not a new bug. The old code fails 
> registration, does a printk, and then sets dev->reg_state = NETREG_REGISTERED. 

OK, fair enough. But anyway, is it valid to leave reg_state as NETREG_REGISTERED when the
registration has failed?

Cheers,
Chris



		
___________________________________________________________ 
Yahoo! Photos – NEW, now offering a quality print service from just 7p a photo http://uk.photos.yahoo.com
