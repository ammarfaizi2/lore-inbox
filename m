Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbULOVWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbULOVWE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 16:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbULOVWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 16:22:04 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:385
	"HELO linuxace.com") by vger.kernel.org with SMTP id S262498AbULOVT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 16:19:57 -0500
Date: Wed, 15 Dec 2004 13:19:53 -0800
From: Phil Oester <kernel@linuxace.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, shemminger@osdl.org,
       davem@redhat.com
Subject: Re: udp_poll breaks vpnc
Message-ID: <20041215211953.GA17945@linuxace.com>
References: <20041215131342.21768388@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215131342.21768388@lembas.zaitcev.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 01:13:42PM -0800, Pete Zaitcev wrote:
> Hi, Guys:
> 
> I found that the attached patch breaks VPNC. By looking at strace, it never
> gets any poll events about arriving encrypted data. It may be a bug in VPNC,
> but this is a rather old binary which I used even on 2.4...

This was fixed post-rc3.

Phil
