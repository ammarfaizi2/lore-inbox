Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSFTUTx>; Thu, 20 Jun 2002 16:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSFTUTw>; Thu, 20 Jun 2002 16:19:52 -0400
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:8175 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S315442AbSFTUTw>; Thu, 20 Jun 2002 16:19:52 -0400
Date: Thu, 20 Jun 2002 21:19:51 +0100
From: Edmund GRIMLEY EVANS <edmundo@rano.org>
To: linux-kernel@vger.kernel.org
Subject: lutime() for changing times of a symbolic link
Message-ID: <20020620201951.GA3853@rano.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With linux-2.4.18 it seems to be impossible to change the access and
modification times of a symbolic link because utime() follows links.
Is there any reason not to add an lutime() system call, analogously
with chown and lchown?

Obviously it's not a burning issue, but it would enable tar xf to do
its job properly and remove what looks like an anomaly.

Edmund
