Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262148AbSKCQeg>; Sun, 3 Nov 2002 11:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262152AbSKCQef>; Sun, 3 Nov 2002 11:34:35 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:47031 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262148AbSKCQed>; Sun, 3 Nov 2002 11:34:33 -0500
Date: Sun, 3 Nov 2002 17:40:43 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021103164043.GA3271@lina.inka.de>
References: <1036328263.29642.23.camel@irongate.swansea.linux.org.uk> <E188MXo-00074b-00@sites.inka.de> <20021103173016.E30076@vestdata.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021103173016.E30076@vestdata.no>
User-Agent: Mutt/1.4i
From: Bernd Eckenfels <ecki@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 05:30:16PM +0100, Ragnar Kjørstad wrote:
> Unfortenately it will be much harder to find all executables with
> increased capabilities on your system. 

Depends if you insert the capabilities/checksum into single files all over
your file system or in a central /etc/capabilities.conf file. The later is a
bit like other security linux distributions and has clearly the advantage of
beeing more obvious.

The scheme could be extended for non capability related integrity checking.
For exampel all root programs need to be listed there with checksums or
someting like that.

Greetings
Bernd
