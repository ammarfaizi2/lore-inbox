Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264845AbSJPODQ>; Wed, 16 Oct 2002 10:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbSJPODQ>; Wed, 16 Oct 2002 10:03:16 -0400
Received: from falcon.etf.bg.ac.yu ([147.91.8.233]:53206 "EHLO
	falcon.etf.bg.ac.yu") by vger.kernel.org with ESMTP
	id <S264845AbSJPODP>; Wed, 16 Oct 2002 10:03:15 -0400
Date: Wed, 16 Oct 2002 16:08:54 +0200 (CEST)
From: Bosko Radivojevic <bole@etf.bg.ac.yu>
To: linux-kernel@vger.kernel.org
Subject: Linux Security Protection System
In-Reply-To: <Pine.LNX.4.44.0210161018370.19750-100000@alumno.inacap.cl>
Message-ID: <Pine.LNX.4.44.0210161607590.28724-100000@falcon.etf.bg.ac.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LinSec team is proud to announce first stable release of LinSec.

LinSec, as the name says, is Linux Security Protection System. The main aim
of LinSec is to introduce Mandatory Access Control (MAC) mechanism into
Linux (as opposed to existing Discretionary Access Control mechanism).
LinSec model is based on:

    * Capabilities
    * Filesystem Access Domains
    * IP Labeling Lists
    * Socket Access Control

As for Capabilities, LinSec heavily extends the Linux native capability
model to allow fine grained delegation of individual capabilities to both
users and programs on the system. No more allmighty root!

Filesystem Access Domain subsystem allows restriction of accessible
filesystem parts for both individual users and programs. Now you can
restrict user activities to only its home, mailbox etc. Filesystem Access
Domains works on device, dir and individual file granularity.

IP Labeling lists enable restriction on allowed network connections on per
program basis. From now on, you may configure your policy so that no one
except your favorite MTA can connect to remote port 25

Socket Access Control model enables fine grained socket access control by
associating, with each socket, a set of capabilities required for a local
process to connect to the socket.

LinSec consists of two parts: kernel patch (currently for 2.4.18) and
userspace tools.

Detailed documentation, download & mailing list information -
http://www.linsec.org

