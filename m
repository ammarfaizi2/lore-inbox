Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVARORc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVARORc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 09:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVARORb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 09:17:31 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:7136 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S261305AbVARORK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 09:17:10 -0500
Date: Tue, 18 Jan 2005 15:17:07 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>,
       "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118141707.GA11385@speedy.student.utwente.nl>
References: <2E314DE03538984BA5634F12115B3A4E01BC42AE@email1.mitretek.org> <20050118140203.GH2839@darkside.22.kls.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118140203.GH2839@darkside.22.kls.lan>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not just use dd if=/dev/xxx `blockdev --getbsz /dev/xxx` ...?

	Sytse
