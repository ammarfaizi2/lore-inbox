Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbTAUT07>; Tue, 21 Jan 2003 14:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbTAUT07>; Tue, 21 Jan 2003 14:26:59 -0500
Received: from comtv.ru ([217.10.32.4]:136 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S267179AbTAUT06>;
	Tue, 21 Jan 2003 14:26:58 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC] vmtruncate releases pages of MAP_PRIVATE vma
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 21 Jan 2003 22:26:25 +0300
Message-ID: <m3hec2i9su.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good day!

I've just encountered that vmtruncate() releases all pages of
selected VMA. It does even if VMA is MAP_PRIVATE. Is this right
behaviour?

I think vmtruncate() should preserve that pages. 

with best regards, Alex

