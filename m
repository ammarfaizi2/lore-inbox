Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289299AbSBEAHa>; Mon, 4 Feb 2002 19:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289308AbSBEAHU>; Mon, 4 Feb 2002 19:07:20 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:33425 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289299AbSBEAHH>; Mon, 4 Feb 2002 19:07:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: linux-kernel@vger.kernel.org
Subject: current->state after kmalloc
Date: Tue, 5 Feb 2002 01:06:41 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16Xt8Y-1SQ44eC@fwd04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

if I do

set_current_state(TASK_INTERRUPTIBLE);
kmalloc(sizeof(struct x), GFP_KERNEL);

what is current->state after kmalloc ?

	Regards
		Oliver
