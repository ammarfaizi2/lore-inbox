Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272821AbTHEOuH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 10:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272822AbTHEOuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 10:50:07 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:58767
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S272821AbTHEOuF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 10:50:05 -0400
Date: Tue, 5 Aug 2003 11:04:58 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: IDE as modules in 2.4.21
Message-ID: <20030805110458.A6070@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a circular dependancy problem when I compile IDE as modules.  It did
not do this with 2.4.20.

ide.o depends on ide-lib and ide-iops
ide-iops.c depends on ide and ide-lib

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
