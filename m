Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVJ0Qpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVJ0Qpe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 12:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVJ0Qpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 12:45:34 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:4083 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751262AbVJ0Qpd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 12:45:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pnoZptDwIMZJb0XQmxSsCoru2e3Tnv0BfSjtPEvKHSmSEyxhpNdklpTWTYZ/jCoFB24otePYZhCv7LxE91xt10A08syWZ0onpnjQ4EzvoE1+5SIc2CCzEi3RpaHrO2cyplap28RmMn0Fn3bNHbLBmUSZ3TQoGgflsaPQUSUCF/o=
Message-ID: <4ae3c140510270945w286cbcf5j7e7a4bde454526b5@mail.gmail.com>
Date: Thu, 27 Oct 2005 12:45:33 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: is rpc_call blocking and wait for reponse before returning to the caller?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to implement a mechanism similar to rpc. So I might want
to know whether rpc_call return only after it receive response from
the server.

If so, how does it achieve asynchronous operation?

Thanks,

Xin
