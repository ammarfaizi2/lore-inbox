Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVFVX4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVFVX4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVFVX4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:56:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22495 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261220AbVFVXya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 19:54:30 -0400
Date: Wed, 22 Jun 2005 19:54:26 -0400 (EDT)
From: Rik Van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Stuart_Hayes@Dell.com
cc: linux-kernel@vger.kernel.org
Subject: Re: page allocation/attributes question (i386/x86_64 specific)
In-Reply-To: <7A8F92187EF7A249BF847F1BF4903C040240AE3C@ausx2kmpc103.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.61.0506221954080.17731@chimarrao.boston.redhat.com>
References: <7A8F92187EF7A249BF847F1BF4903C040240AE3C@ausx2kmpc103.aus.amer.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005 Stuart_Hayes@Dell.com wrote:

> My question is this:  when split_large_page() is called, should it make
> the other 511 PTEs inherit the page attributes from the large page (with
> the exception of PAGE_PSE, obviously)?

I suspect it should.

-- 
The Theory of Escalating Commitment: "The cost of continuing mistakes is
borne by others, while the cost of admitting mistakes is borne by yourself."
  -- Joseph Stiglitz, Nobel Laureate in Economics
