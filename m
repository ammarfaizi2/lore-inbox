Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbUA3Rf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbUA3Rf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:35:29 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:5582 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262805AbUA3RfT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:35:19 -0500
Date: Fri, 30 Jan 2004 18:35:16 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.2-rc2 (BK): /proc/bus/input/devices information for joystick bogus?
Message-ID: <20040130173516.GA4517@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see this in /proc/bus/input/devices:

I: Bus=0014 Vendor=0001 Product=000f Version=0100
N: Name="Analog 3-axis 4-button joystick"
P: Phys=<NULL>/input0
H: Handlers=js0 
B: EV=b 
B: KEY=1b 0 0 0 0 0 0 0 0 0 
B: ABS=83 

The <NULL> tag seems to confuse hotplug's input.rc. Where does it come
from? How can the kernel see the Joystick without knowing the phys
address?

(This was also filed as SourceForge.net bug #887724 to the linux-hotplug
project.)

TIA,

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
