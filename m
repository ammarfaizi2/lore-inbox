Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262557AbTCISCP>; Sun, 9 Mar 2003 13:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262558AbTCISCP>; Sun, 9 Mar 2003 13:02:15 -0500
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:63905 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262557AbTCISCO>; Sun, 9 Mar 2003 13:02:14 -0500
Date: Sun, 9 Mar 2003 13:18:33 -0500
To: linux-kernel@vger.kernel.org
Subject: tbench 192 "failed to start 192 clients" on 2.5.64
Message-ID: <20030309181833.GA3168@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On quad Xeon P3, tbench 192 on some 2.5 kernels have been giving this lately:
FAILED TO START 192 CLIENTS (started 190)

The number of clients started varies from 168 - 190 (should be 192).

For the clients that don't start, the logfile shows:
error reading header

The kernel's labeled "badrun" had this behaviour.
There has been no problem running tbench 64 on this machine.

2.5.54-mm3                      112.54 MB/second
2.5.55                          120.79
2.5.56                          117.46
2.5.58                          118.46
2.5.59                          119.11
2.5.59-mjb3                     116.85
2.5.59-mm2                      841.02 badrun
2.5.59-mm5                      117.93
2.5.59-mm6                      841.27 badrun
2.5.59-mm7                      119.31
2.5.59feral                     119.87
2.5.60bk3                       840.98 badrun
2.5.62                          119.83
2.5.62-mjb2                     119.00
2.5.62-mm2                      818.36 badrun
2.5.63                          118.21
2.5.63-mjb2                     119.60
2.5.63-mm2-dline                818.34 badrun
2.5.64                          818.36 badrun

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

