Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbTH0VlR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 17:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbTH0VlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 17:41:17 -0400
Received: from [66.155.158.133] ([66.155.158.133]:643 "EHLO ns.waumbecmill.com")
	by vger.kernel.org with ESMTP id S262265AbTH0VlQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 17:41:16 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: linux-kernel@vger.kernel.org
Subject: binary kernel drivers re. hpt370 and redhat
Date: Wed, 27 Aug 2003 18:40:30 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200308271840.30368.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a client who has a raid controller currently supported under windows, 
and now wants to support linux as a bootable device.  Currently, some of 
their trade secrets are contained in the driver as opposed to the controller 
firmware, etc., so for now they wish to release a binary-only driver to 
certain beta customers.  (i.e., 1st stage of porting is similar functionality 
as windows). Am I correct that in order to boot off of this device that the 
driver would have to be statically linked in vs. a module which could be 
distributed as a binary-only driver keyed to the kernel.revision of the 
distribution's kernel?  I would like to avoid any flames and ask that all 
recognize that some hardware providers are having to ease into the pond a toe 
at a time.  Any constructive thoughts, suggestions, references, tips, etc. 
highly appreciated.


-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL 603-232-3115 FAX 603-625-5809 MOBILE 603-493-2386
www.briggsmedia.com
