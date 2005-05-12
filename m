Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVELB7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVELB7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 21:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVELB7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 21:59:10 -0400
Received: from animx.eu.org ([216.98.75.249]:35986 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261284AbVELB7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 21:59:07 -0400
Date: Wed, 11 May 2005 21:57:49 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Modules on 2.6 kernels
Message-ID: <20050512015749.GA31651@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed that some modules have a large .modinfo section (ie
aic79xx.ko).  Is there anyway to strip the alias definitions from the
module?  Or is it possible to strip .modinfo entirely?

I'm working in constrained space on this one and would like to get it
smaller if possible.  I am currently using almost 1400kb of space (This is
on a floppy if you want to know).

I went through all the modules that I place in this space and removed the
.modinfo section.  This freed 300kb of space.  I haven't tested the modules
to see if they will work or not.  (Used objcopy -R .modinfo to remove)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
