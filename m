Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264123AbTEGR7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbTEGR7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:59:11 -0400
Received: from franka.aracnet.com ([216.99.193.44]:57517 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264123AbTEGR7K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:59:10 -0400
Date: Wed, 07 May 2003 08:57:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 672] New: laptop internal pointer and usb external mouse both appear on mouse0 
Message-ID: <11720000.1052323051@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=672

           Summary: laptop internal pointer and usb external mouse both
                    appear on mouse0
    Kernel Version: 2.5.69
            Status: NEW
          Severity: normal
             Owner: vojtech@suse.cz
         Submitter: jvb@prairienet.org


Distribution:  Debian unstable
Hardware Environment:  Toshiba Libretto L5 laptop

Both my laptop's PS/2 internal pointer and an external USB mouse appear on
/dev/input/mouse0.  This contradicts what is stated in input.txt ("each mouse
device is assiged to a single mouse"), and is undesired because I'd like to
configure each device differently in X.


