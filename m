Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWHKQKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWHKQKR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 12:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWHKQKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 12:10:16 -0400
Received: from ns.suse.de ([195.135.220.2]:47049 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932180AbWHKQKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 12:10:14 -0400
From: Andi Kleen <ak@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH for review] [67/145] x86_64: Detect CFI support in the assembler at runtime
Date: Fri, 11 Aug 2006 18:10:02 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060810935.775038000@suse.de> <200608110755.58676.ak@suse.de> <20060811151638.GA9211@mars.ravnborg.org>
In-Reply-To: <20060811151638.GA9211@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608111810.02673.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> $$$$ becomes $$ when executed.

Ok changed thanks.
 
> I have no better alternatives - except maybe for mktemp.



I personally dislike mktemp btw because it eats up precious
/dev/random entropy for something relatively silly

-Andi
