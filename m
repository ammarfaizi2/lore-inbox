Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWGLJJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWGLJJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 05:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWGLJJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 05:09:05 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:21120 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750993AbWGLJJE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 05:09:04 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [ACPI] Fix section for CPU init functions
Date: Wed, 12 Jul 2006 11:09:08 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060712090908.13118.45820.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI processor init functions should be marked as __cpuinit as they
use structures marked with __cpuinitdata.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 0 files changed, 0 insertions(+), 0 deletions(-)


