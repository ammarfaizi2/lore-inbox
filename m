Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVAKJtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVAKJtv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVAKJtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:49:51 -0500
Received: from mail.enyo.de ([212.9.189.167]:50876 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262639AbVAKJtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:49:49 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Steve Bergman <steve@rueb.com>, linux-kernel@vger.kernel.org
Subject: Re: Proper procedure for reporting possible security vulnerabilities?
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de>
	<41E2F6B3.9060008@rueb.com>
	<Pine.LNX.4.61.0501102309270.2987@dragon.hygekrogen.localhost>
Date: Tue, 11 Jan 2005 10:49:47 +0100
In-Reply-To: <Pine.LNX.4.61.0501102309270.2987@dragon.hygekrogen.localhost>
	(Jesper Juhl's message of "Mon, 10 Jan 2005 23:11:27 +0100 (CET)")
Message-ID: <876524s3b8.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jesper Juhl:

> I don't know what other people would do or what the general feeling on 
> the list is, but personally I'd send such reports to the maintainer and 
> CC lkml, if there is no maintainer I'd just send to lkml.

Nevertheless, it would be good to have a designated security contact
just in case, when something is discovered that needs a more
coordinated form of disclosure.  Death by a single IP packet in the
default configuration, for example.

Local privilege escalation (or even denial-of-service) is not really
relevant.  We know from experience that Linux does not enforce local
account separation and won't do so for the forseeable future, and the
prudent don't rely on it.
