Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbTJEV43 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 17:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbTJEV43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 17:56:29 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:18707
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263884AbTJEV42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 17:56:28 -0400
Date: Sun, 5 Oct 2003 14:56:27 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Hacksaw <hacksaw@hacksaw.org>
Cc: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: swap and 2.4.20
Message-ID: <20031005215627.GE1205@matchmail.com>
Mail-Followup-To: Hacksaw <hacksaw@hacksaw.org>,
	Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
	linux-kernel@vger.kernel.org
References: <E1A6DVX-0007dB-00@calista.inka.de> <200310052007.h95K7X6M007980@habitrail.home.fools-errant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310052007.h95K7X6M007980@habitrail.home.fools-errant.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 04:07:33PM -0400, Hacksaw wrote:
> Does this mean that you could replace a library out from under a running but 
> largely paged out app, and have it suddenly switch to the new library?

Technically yes, but realistically no.

You'd more likely crash the app since maybe only a few pages of the new code
were paged in, and nothing says that it's the update of the code you wanted...
