Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264952AbTIDMZj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbTIDMZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:25:39 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:52740 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264952AbTIDMZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:25:38 -0400
Date: Thu, 4 Sep 2003 14:25:34 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Frederic Gobry <frederic.gobry@smartdata.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 does not detect my touchpad
Message-ID: <20030904142534.A2949@pclin040.win.tue.nl>
References: <20030904115044.GA7114@rhin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030904115044.GA7114@rhin>; from frederic.gobry@smartdata.ch on Thu, Sep 04, 2003 at 01:50:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 01:50:44PM +0200, Frederic Gobry wrote:

> Is there a way to perform some probing on the PS/2 port, so that I can
> provide more detailed info ?

If you #define DEBUG in i8042.c and make sure you use a large
log buffer then all probing is logged via syslog, and we can
see what was sent and how the touchpad reacted.

