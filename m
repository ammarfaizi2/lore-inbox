Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbUEJUrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUEJUrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 16:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUEJUrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 16:47:09 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:17850 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261597AbUEJUrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 16:47:07 -0400
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.3  (F2.71; T1.001; A1.60; B2.21; Q2.21)
From: "Joey Dewille" <joey1968@fastmail.co.uk>
To: linux-kernel@vger.kernel.org
Date: Mon, 10 May 2004 22:47:02 +0200
X-Sasl-Enc: nAvJWdfA9GSF4amD157bog 1084222022
Message-Id: <1084222022.28156.196200145@webmail.messagingengine.com>
Subject: how to deduce connect/accept history from struct sock?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Say a module is inserted that intercepts all socket operations and
it happened in the middle of several established connections.
Save me some time please and answer what fields in struct sock
or elsewhere can be examined to determine reliably if the current
established
connections had been accepted (i.e. accept call) or initiated (i.e.
connect)
from the local machine.
--Joey 

-- 
http://www.fastmail.fm - A fast, anti-spam email service.
