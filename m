Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbTIIRix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbTIIRiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:38:52 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:22025
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264278AbTIIRiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:38:52 -0400
Date: Tue, 9 Sep 2003 10:39:10 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Brad Parker <parker@citynetwireless.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in sched.c
Message-ID: <20030909173910.GA28279@matchmail.com>
Mail-Followup-To: Brad Parker <parker@citynetwireless.net>,
	linux-kernel@vger.kernel.org
References: <007e01c3766a$bd0f8df0$6ff6d618@bp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007e01c3766a$bd0f8df0$6ff6d618@bp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 07:38:50PM -0500, Brad Parker wrote:
> I got a kernel BUG mentioning the process ospfd (zebra/quagga routing
> protocol daemon) while trying to  "shutdown -r now", I already contaced the
> quagga people, but I thought maybe this would be a kernel issue, so here
> goes:

You need to run it through ksymoops with the same modules loaded in the same
order also.
