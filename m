Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290059AbSAOR1h>; Tue, 15 Jan 2002 12:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290053AbSAOR11>; Tue, 15 Jan 2002 12:27:27 -0500
Received: from bbnrel4.hp.com ([155.208.254.68]:3601 "HELO
	bbnrel4.net.external.hp.com") by vger.kernel.org with SMTP
	id <S290047AbSAOR1S>; Tue, 15 Jan 2002 12:27:18 -0500
Message-ID: <3C446673.5000709@hp.com>
Date: Tue, 15 Jan 2002 18:27:15 +0100
From: Francois-Xavier Kowalski <francois-xavier_kowalski@hp.com>
Reply-To: francois-xavier_kowalski@hp.com, francois-xavier_kowalski@hp.com
Organization: Hewlett-Packard
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: [Q] module_init()'s order of execution?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

AFAIK, the macros module_init() and module_exit() are used both in case
a source is built-in (the code is called from the init stage) or as a
kernel module (implementing a init_module symbol).

In case 2 of /built-in/ modules (or more) I am wondering if it is
possible to know by advance the order used to call the various
module_init() entry points. Is it possible to fix this order, or to
setup a dependency between 2 module_init()?

TIA

-- FiX


