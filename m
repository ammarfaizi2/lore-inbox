Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbTF3Unz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 16:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265884AbTF3Unz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 16:43:55 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30096
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265875AbTF3Unz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 16:43:55 -0400
Subject: Re: delegating to a cpu
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Raghava Raju <vraghava_raju@yahoo.com>
Cc: arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030630200949.96698.qmail@web20003.mail.yahoo.com>
References: <20030630200949.96698.qmail@web20003.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057006524.17589.35.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jun 2003 21:55:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unless your other work is really expensive its doubtful another CPU will
help you. If it is then probably you want to have threads that you pin
to each CPU (with the cpu affinity calls) and wake. You do want to work 
hard to keep the same data being needed on both CPUs however

