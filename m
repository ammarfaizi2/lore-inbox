Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264634AbTFQILj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 04:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbTFQILj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 04:11:39 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:9995 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S264634AbTFQILj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 04:11:39 -0400
Date: Tue, 17 Jun 2003 10:25:54 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: linux 2.5.71: net/core/flow.c missing #include <linux/cpu.h>
Message-ID: <20030617082554.GA24752@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In uniprocessor kernels, this generates an unresolved external reference
to register_cpu_notifier.

Felix
