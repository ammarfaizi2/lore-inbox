Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268175AbUJSLhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268175AbUJSLhm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 07:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268136AbUJSLhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 07:37:41 -0400
Received: from mail58-s.fg.online.no ([148.122.161.58]:12509 "EHLO
	mail58-s.fg.online.no") by vger.kernel.org with ESMTP
	id S269422AbUJSKqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 06:46:09 -0400
To: linux-kernel@vger.kernel.org
Subject: vsftpd and ssl: causing timeout and reconnect messages
From: Esben Stien <b0ef@esben-stien.name>
Organization: People's Front Against the New World Order
X-Home-Page: http://www.esben-stien.name
Date: Tue, 19 Oct 2004 12:46:06 +0200
Message-ID: <87r7nvvvdd.fsf@esben-stien.name>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've set up vsftpd with ftps support (ftp over ssl) on a computer
(linux-2.6.8.1) in my dmz. The bastion is running netfilter. My users
are experiencing timeouts and reconnects all the time. When I turn off
ssl support this does not happen. This happends in both active and
passive modes.

The user is eventually able to transfer the file by reconnecting and
resuming the file.

A user using lftp reported this error message:

get: Fatal error: SSL read: wrong version number

, but he was still able to transfer the file by reconnecting and
resuming.

All I get in my logs is:

421 Data timeout. Reconnect. Sorry.

Is this a known problem with vsftpd?. I'd like to know if this is only
a problem with me. Are there anyone who is using vsftpd with ssl
support running flawlessly?.

Esben

-- 
Esben Stien is b0ef@esben-stien.name
http://www.esben-stien.name
irc://irc.esben-stien.name/%23contact
[sip|iax]:b0ef@esben-stien.name
