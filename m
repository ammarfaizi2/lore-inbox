Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVAEOP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVAEOP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVAEOP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:15:28 -0500
Received: from gate.firmix.at ([80.109.18.208]:13699 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S262439AbVAEOPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:15:24 -0500
Subject: Re: Purpose of do{}while(0) in #define spin_lock_init(x)	do {
	(x)->lock = 0; } while(0)
From: Bernd Petrovitsch <bernd@firmix.at>
To: "Kotian, Deepak" <Deepak.Kotian@patni.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <374639AB1012AA4C840022842AA95BC203E0E7E3@ruby.patni.com>
References: <374639AB1012AA4C840022842AA95BC203E0E7E3@ruby.patni.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1104934513.28504.18.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Wed, 05 Jan 2005 15:15:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 19:31 +0530, Kotian, Deepak wrote:
> Is there any specific reason why do{}while(0) is 
> there in this definition
> #define spin_lock_init(x)	do { (x)->lock = 0; } while(0)
> 
> What could happen if it is replaced by
> #define spin_lock_init(x)	{ (x)->lock = 0; } 

http://kernelnewbies.org/faq/index.php3#dowhile

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

