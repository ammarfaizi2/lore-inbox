Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTFCRzY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 13:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTFCRzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 13:55:24 -0400
Received: from mx9.mail.ru ([194.67.23.29]:46606 "EHLO mx9.mail.ru")
	by vger.kernel.org with ESMTP id S261411AbTFCRzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 13:55:24 -0400
Date: Wed, 4 Jun 2003 01:08:48 +0700
From: Anton Petrusevich <casus@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: capacity in 2.5.70-mm3
Message-ID: <20030603180848.GA4105@casus.home.my>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I am not sure if you are already aware ot not, but looks like nobody
noticed it yet. Look:
casus:anton$ ls /proc/ide/hda
cache     capacity  geometry  media  settings          smart_values
capacity  driver    identify  model  smart_thresholds
casus:anton$ ls /proc/ide/hdc
capacity  capacity  capacity  driver  identify  media  model  settings

Multiplay capacity files. Funny :)
-- 
Anton Petrusevich

