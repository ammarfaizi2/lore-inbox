Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424372AbWKPTTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424372AbWKPTTv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 14:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424375AbWKPTTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 14:19:51 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:16925 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1424372AbWKPTTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 14:19:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=N/kQ3iOJ2yfif6q2dE7iaUJe8dLSBrucB4JesBKUTDIuRgSy6EqKYsB25voI2MimFkguBOpWYES9chFkyRZZAKwuKvw4eMUlrJvZMPxJ5Ms9R77HpEtPbB5utWwWauZ0ZYc1CF4q3RGp16t+Qu5/dEevdiSCpQHkMBe9mmOfMrE=
Message-ID: <e7aeb7c60611161119h3e198e96va07d36d5b2dd6390@mail.gmail.com>
Date: Thu, 16 Nov 2006 21:19:50 +0200
From: "Yitzchak Eidus" <ieidus@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: changing internal kernel system mechanism in runtime by a module patch
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

is it possible to replace linux kernel internal functions such as
schdule () to lets say my_schdule ()  in a run time with a module
patch???
(so that every call in the kernel to schdule() will go to my_schdule()... ) ???

i am talking about a clean/standard way to do such thing
(without overwrite the mem address of the function and replace it in a
dirty way...)
