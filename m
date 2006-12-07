Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031760AbWLGHKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031760AbWLGHKa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 02:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031761AbWLGHKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 02:10:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42458 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031760AbWLGHK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 02:10:29 -0500
Subject: Re: Obtaining a list of memory address ranges allocated to
	processes
From: Arjan van de Ven <arjan@infradead.org>
To: Stephen Torri <storri@torri.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1165449386.13079.30.camel@base.torri.org>
References: <1165449386.13079.30.camel@base.torri.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 07 Dec 2006 08:10:26 +0100
Message-Id: <1165475426.3233.476.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-06 at 17:56 -0600, Stephen Torri wrote:
> I am trying to create a custom ELF and Windows PE loader for the purpose
> of security research. I am having a difficult time finding how to
> allocate memory for a binary at the desired address in memory
> (especially if its non-relocatable). I would like to see why I cannot
> get memory allocated at the exact address request in the binary headers.
> Is there a program or system call that allows me to see a list of memory
> address ranges allocated to the running processes on a system?

Hi,

check the /proc/<pid>/maps and /proc/<pid>/smaps files... they have
exactly what you need

Greetings,
   Arjan van de Ven

