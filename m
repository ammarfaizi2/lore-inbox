Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262853AbTDAUnM>; Tue, 1 Apr 2003 15:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262854AbTDAUnM>; Tue, 1 Apr 2003 15:43:12 -0500
Received: from gw.enyo.de ([212.9.189.178]:39428 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S262853AbTDAUnL>;
	Tue, 1 Apr 2003 15:43:11 -0500
To: linux-kernel@vger.kernel.org
Subject: Stateless dropping of packets
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Tue, 01 Apr 2003 22:54:34 +0200
Message-ID: <87he9ilz05.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090017 (Oort Gnus v0.17) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to drop packets, preferably using 2.4 iptables, before
the packet triggers updates of some caches (e.g. the route cache)?

On one particular host, I saw the route cache explode, despite all
packets being dropped (using a DROP rule).
