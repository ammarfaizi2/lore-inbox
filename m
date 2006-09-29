Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422828AbWI2Vmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422828AbWI2Vmo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422833AbWI2Vmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:42:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:1643 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422828AbWI2Vmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:42:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=HkbqbWSi9LBcLD6SVOSv/JGSEjkrzBvAssuw/WbIsbUPhhUcQ3tJ3mYzZcx27FLHZ8v3nhb0jFwsI6maW1jLsRPyHsAckJhx26ntgr9yLhUd0Z0RJIu+CyXrBN4ATYEx+f9roTfIq76zY6YndkcLM+WeKGmZ/1ib5fCL7d/K4fU=
Date: Sat, 30 Sep 2006 01:44:12 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.osdl.org, matt@nomadgs.com, amit.kucheria@nokia.com,
       igor.stoppa@nokia.com, ext-Tuukka.Tikkanen@nokia.com
Subject: PowerOP, Whatchanged/Issues/TODO 2/2
Message-Id: <20060930014412.98405be8.eugeny.mints@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.15; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

whatchanged:
- new concept of powerop power parameter is introduced
- new powerop core interface routine to set individual(or subset of)
  power parameter value is added
- no more string parsing at any layer
- no more va_list interface 
- powerop driver module refcounting is added
- documentation file including optional sysfs interface description is added

todo/issues:
- better implementation for getting registered operating point names
- configfs for operating points creation from user space



