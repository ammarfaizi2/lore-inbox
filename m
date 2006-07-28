Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751965AbWG0Tp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbWG0Tp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbWG0Tp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:45:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:39780 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751965AbWG0Tp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:45:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=IpVXG6nES/1kCjamgOmUGASzenrWO0jKVVfJdZ50byDUoeCPCKf4w9ENaIZI9vpvXFqpWChFWH+VmmxlC3At0lKv5TSpXRO9VwfW8EoQ0g8eR0okQSqVV6rZYwDOQjlaUvVszGSJopIIbVdLfouErc+Kriq8XdqX1ygO5INUFwE=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Subject: Kubuntu's udev broken with 2.6.18-rc2-mm1
Date: Fri, 28 Jul 2006 15:46:08 -0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060727015639.9c89db57.akpm@osdl.org>
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607281546.09592.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Some change between -rc1-mm2 and -rc2-mm1 broke Kubuntu's udev
(079-0ubuntu34). In particular /dev/mem went missing, and /dev/null had
bogus permissions (crw-------). I've kludged around the problem by
populating /lib/udev/devices from a good /dev, but I'm assuming the
breakage was unintentional.

Andrew Wade
