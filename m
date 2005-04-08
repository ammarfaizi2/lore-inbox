Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVDHN2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVDHN2G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 09:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbVDHN1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 09:27:15 -0400
Received: from mx2.mail.ru ([194.67.23.122]:62306 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S262844AbVDHNZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 09:25:35 -0400
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Martin Waitz <tali@admingilde.org>
Subject: Re: 2.6.12-rc2-mm2
Date: Fri, 8 Apr 2005 17:28:25 +0000
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
References: <20050408030835.4941cd98.akpm@osdl.org>
In-Reply-To: <20050408030835.4941cd98.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504081728.25974.adobriyan@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 April 2005 10:08, Andrew Morton wrote:

> +docbook-use-xmlto-to-process-the-docbook-files.patch

htmldocs (haven't look at pdf, etc...) became K&R'ish.
============================================================================
Synopsis

struct sk_buff * skb_share_check (skb,
                                  pri);

struct sk_buff * skb;
int              pri;
============================================================================

Also, Documentation/Docbook/*.html uses book1.html, but there are only 
Documentation/Docbook/*/index.html

Functions are not hyperlinked from index.html. IIRC, they were in jadetex 
days.
