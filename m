Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbUJ0NvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbUJ0NvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUJ0NvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:51:14 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:23272 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262440AbUJ0Nu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:50:57 -0400
Date: Wed, 27 Oct 2004 15:50:52 +0200
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: 2.6.10-mm1, class_simple_* and GPL addition
Message-ID: <20041027135052.GE32199@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

The change from 
	EXPORT_SYMBOL
to
	EXPORT_SYMBOL_GPL
for class_simple_* makes the nvidia module useless as it uses several:
nvidia: Unknown symbol class_simple_device_add
nvidia: Unknown symbol class_simple_destroy
nvidia: Unknown symbol class_simple_device_remove
nvidia: Unknown symbol class_simple_create

I don't want to start a flame war and long discussion, just want to ask
wether this change (to _GPL) was intended, and if yes, if there is a way
to fix nvidia kernel modules (or others) using this device management
interface.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
ABERCRAVE (vb.)
To strongly desire to swing from the pole on the rear footplate of a
bus.
			--- Douglas Adams, The Meaning of Liff
