Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162468AbWLBUrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162468AbWLBUrq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 15:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162477AbWLBUrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 15:47:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:47583 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1162468AbWLBUro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 15:47:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=nswdGey0c8o29t06PrB1JKuvjNYAx+vLxQnxga0aDEoF62OOOV90/EZGqUetfTUN7Q3A6c/37OTTBrR+Yb6DqzxR639XouHif54y62nLekrQzj0mFDdWjFFrf871zcHgNJPIwgW38Tu5KoTLcr8dIMhguLjIvN+ykomJAz9aOQc=
Date: Sat, 2 Dec 2006 23:47:44 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: David Binderman <dcb314@hotmail.com>
Subject: icc: many "was set but never used" warnings
Message-ID: <20061202204744.GA5030@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Binderman compiled 2.6.19 with icc and grepped for "was set but never
used". Many warnings are on
	http://coderock.org/kj/unused-2.6.19-fs
	http://coderock.org/kj/unused-2.6.19-net
	http://coderock.org/kj/unused-2.6.19-sound
	http://coderock.org/kj/unused-2.6.19-drivers

