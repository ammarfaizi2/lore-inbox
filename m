Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162999AbWLBNnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162999AbWLBNnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 08:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163004AbWLBNnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 08:43:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54720 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1163002AbWLBNnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 08:43:06 -0500
Subject: Re: [PATCH 2.6.19] struct seq_operations and struct
	file_operations constification
From: Arjan van de Ven <arjan@infradead.org>
To: Helge Deller <deller@gmx.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200612021355.47945.deller@gmx.de>
References: <200612021355.47945.deller@gmx.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 02 Dec 2006 14:43:04 +0100
Message-Id: <1165066984.3233.163.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-02 at 13:55 +0100, Helge Deller wrote:
> this trivial patch 
> - moves some file_operations structs into the .rodata section
> - moves static strings from policy_types[] array into the .rodata section
> - fixes generic seq_operations usages, so that those structs may be defined as "const" as well
> 
> tested on ia32
> patch was already sent on 1006-10-08

looks good and is a useful cleanup;

Acked-by: Arjan van de Ven <arjan@linux.intel.com>

