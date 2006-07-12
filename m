Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWGLDz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWGLDz0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWGLDz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:55:26 -0400
Received: from main.gmane.org ([80.91.229.2]:36776 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932400AbWGLDzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:55:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ask List <askthelist@gmail.com>
Subject: Re: Runnable threads on run queue
Date: Wed, 12 Jul 2006 03:55:13 +0000 (UTC)
Message-ID: <loom.20060712T051204-221@post.gmane.org>
References: <loom.20060708T220409-206@post.gmane.org> <44B0BF4F.7070102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.237.13.5 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.4) Gecko/20060508 Firefox/1.5.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are not running sendmail. We developed our own mail server in-house. We have
a cluster of these mail servers sending spam traffic to a cluster of SA servers
and we use the round-robin parameter when starting the spamd process and start
the daemon with a ton of min/spare/max children. So we dont see the forking
issue you mention. 

