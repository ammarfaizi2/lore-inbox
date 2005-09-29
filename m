Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVI2MJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVI2MJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 08:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVI2MJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 08:09:28 -0400
Received: from 85-50-2-236.bcn1.adsl.uni2.es ([85.50.2.236]:40812 "EHLO
	puil.ghetto") by vger.kernel.org with ESMTP id S1751090AbVI2MJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 08:09:27 -0400
Date: Thu, 29 Sep 2005 14:09:13 +0200
To: linux-kernel@vger.kernel.org
Subject: Fastest way to do socket IO on Linux
Message-ID: <20050929120912.GA12054@larroy.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Which is the fastest way to do socket IO from an scalable perspective?
Afaik AIO doesn't work on sockets yet, and select has too much overhead
when you have to test if many fds are set, epoll could be it? Is
expected to have AIO working on sockets some day?

Regards.
-- 
Pedro Larroy Tovar, pedro at larroy dot com | http://pedro.larroy.com/
  * Las patentes de programación son nocivas para la innovación * 
               http://proinnova.hispalinux.es/
