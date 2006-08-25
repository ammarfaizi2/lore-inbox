Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWHYOFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWHYOFo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWHYOFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:05:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61348 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932334AbWHYOFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:05:43 -0400
Subject: Re: [PATCH] Ban register_filesystem(NULL);
From: Arjan van de Ven <arjan@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060825010536.GI5204@martell.zuzino.mipt.ru>
References: <20060825010536.GI5204@martell.zuzino.mipt.ru>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 25 Aug 2006 16:05:36 +0200
Message-Id: <1156514736.3032.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 05:05 +0400, Alexey Dobriyan wrote:
> Everyone passes valid pointer there.

Hi,

want to add a nonnull attribute to the prototype so that gcc will
enforce this?

Greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

