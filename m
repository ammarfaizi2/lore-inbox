Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272552AbTHKNVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272554AbTHKNVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:21:41 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:44741 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S272552AbTHKNVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:21:40 -0400
Date: Mon, 11 Aug 2003 15:21:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Kconfig -- kill "if you want to read about modules, see" crap?
Message-ID: <20030811132127.GA2596@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Each and every input driver (and other drivers are not better)
contains this

	  This driver is also available as a module ( = code which can be
	  inserted in and removed from the running kernel whenever you want).
	  The module will be called input. If you want to compile it as a
	  module, say M here and read <file:Documentation/modules.txt>.

text. Perhaps having 1000 copies of same help test is bad idea? Maybe
CONFIG_MODULE can explain users what modules are, and we can have help
texts that are actually usefull?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
