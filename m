Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130579AbRBLVTO>; Mon, 12 Feb 2001 16:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130716AbRBLVSy>; Mon, 12 Feb 2001 16:18:54 -0500
Received: from ip110.herrera.iphil.net ([203.176.28.110]:50701 "HELO
	mail.q-linux.com") by vger.kernel.org with SMTP id <S130678AbRBLVSs>;
	Mon, 12 Feb 2001 16:18:48 -0500
Date: Tue, 13 Feb 2001 05:18:43 +0800
From: "Michael J. Maravillo" <mike.maravillo@q-linux.com>
To: linux-kernel@vger.kernel.org
Cc: mike.maravillo@q-linux.com
Subject: 2.4.2-pre[23]: can't mount iso images
Message-ID: <20010213051843.A14523@mail.q-linux.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Q Linux Solutions, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Mounting iso images have been working perfectly well on 2.4.0,
2.4.1, and 2.4.2-pre1, until -pre2 and -pre3.  Attached is an
strace on -pre3, and a diff on -pre3 against -pre1.  All kernels
were compiled using the same config file...

	Thanks in advance,
	Mike
-- 
 .--.  Michael J. Maravillo                   office://+63.2.894.3592/
( () ) Q Linux Solutions, Inc.              mobile://+63.917.897.0919/
 `--\\ A Philippine Open Source Solutions Co.  http://www.q-linux.com/

--ibTvN161/egqYuK8
Content-Type: application/x-bzip2
Content-Disposition: attachment; filename="strace.mount.242p3.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWUye4m4ABhd/gHRdCQ1Yd//iP6/f7r/v339QBXvWaRtsi2AqgBcJIkaKb1U/
Kh6n6T1M1Iaeo2oNDTZTEB6h6jZRp4oADjJk0aA0aYjI0MQwJo0xBiNBhAAYJNSSaakepoBi
DTJoAYCZAZA2hBkAA4yZNGgNGmIyNDEMCaNMQYjQYQAGCKQgBMjUwpk1GhoekA00DQAYIw0T
Ro+BzyHZ6/u7VFmZ6BisQqN1UgabL0l43NIxA1dqSWKh0QojUgkESXu/UfWefqSpWAIJIwBg
qmnVCSIRGEx4IoogO8iC4GAFysfH4bZbTUQJzWMUAthJ0KojtnPD9KbrQr3eXndj5TXo7KnO
nq2+fkBQYZkDRbVf3b7IqIYhTV857vAqIiJtaNQSzqQpI9Jg2CQf3RSnLNLCyPkaq7h6XhvG
CmDuCaBDwb8tf9hwOkZ6QUqAGc9tlSuTNjUc9FnWlPT4hzJAZgZik0PeG1NIkbgKpk4y/Ums
yvIrTWC0Oa5Qs0st0yqz7bBXEW3VEwugiChcRC+PUD3im0IJgyBvOrtsZEc/aKwfg4gfRghc
sMQWEdzqoh8K0nVPPE+VC+B0DqigowFiyCgIqHhko7hYB2RhdLE+AgArcvXxT0PRfnxceiLP
ZeiTlBQLGyHISUMGCHsExINlpYvoBsghNNsBBAQKKwVVDLDSZV6WySNX2pkchWCfigsYro8z
mukYYxxXmZ5rkcEk/ebAM6wFmxZgYWwt2uVL446bDjS2rhTHS2RF9kgMs1C9cZxLBDRzKkqq
zJwGIGGm2AvuvqlR1Ki47NwGeUi9qKaEXE4LWsMjEqnPjnMnTv7QNAnlTHZdVWTnctmRYxmF
b4nDwVS8D7+G6yoZUlSmGW1JJxHFMV007LoYNLdQ0yhwiRxGYS41+Fn2ID3er7gnNZHbuHlm
WAVU8yyvUO5Si3YebrmjYL4gzJIW9zUMyL7+tk24RONDENpKIIQ26GjTZVCGcwbbbdP3rQNx
/F1Yvhb4Ccus9Km+W91AI/BIB212B5G0QuJ6sg5gLYKW0raE8sDZHDcASaNjI3ClTgoY5YZA
5lSsJUl0Awep31oBzIbaJyECye7Ekagxxci92UZGRw+cG7UrLjHGAICAu8MjjgWQrBCWgw7i
xZ2g8/Jom20nI27wA63K12D/ZsqGZZWZtEHa5w9eHHHfWC0rUFWjtoFIoDxUJi+SZIp4lknk
B/IR75uJeDx8QfsgkYcBImEv0g8mpe+aaQJhq+iNdy01TaF2cyPAb88nm13qX/6aXi0ysd5N
k1WMBJ9QtdQMzYB5STQ4V8oOPL1qzQtiAOT7BOcGYct7IlEj1km3ZK49ChouZKT7G7AHu8ek
9o/GQ9L0citHoOwaoYMtm1OXZN1mTgZYu0xOkxMbhN6cJdJS1rOkGm4gTMhoRpdMTqhdRcz7
Dec4NLrTvA2wDdLEvZQZHXYoeeuS045koJMGVC7unN6IHf3oE44twOYMivWsDYBUobDiUF3t
7eWbxYEbbKHLtSajFDiWoWhsObV7HQkBXwsvM6MhY22oYKTwM2CzFD/gdQcC/pEmYvMYBvYU
lG4XCBJayR2tjWSsWDZUS31fSWlpwsQUAqpP3EANerKhEQXIB5RvNzGRhksIKMou5IpwoSCZ
PcTc

--ibTvN161/egqYuK8
Content-Type: application/x-bzip2
Content-Disposition: attachment; filename="242p3-242p1.diff.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWbIVlGsAAeF/gHR/wQVQb//y/+//7r/v3+9QBL4UAGszAoDCU1BKekAA9QNB
oAHqNAGgBpk00GgAASkTU9PU1Mk8o0GgAAAAMgA0AAPUABxoaBo0yNNGmQGJggABoDQGmQGB
Mg40NA0aZGmjTIDEwQAA0BoDTIDAmQJEiAEaNE0TNKep5Ceo2k0DTQMjEyY1A2hPU02U3vQt
KgAYbeDj8/FPlqTpgJUuGuSIZCYcDm7OOJOaYk2jldtkVIA4mCSKUB+bSXtmg76OWzuIniPD
1zQg6Zo0jMzAJg2wG36Rw3YRDYxMBptiBswQBFxiifONJLws50ZTOTE/s8frzvBg/sFK+mbC
HGARi9tO8djGwwkMkNtFntbOhsbDSpRur3EpKxFA2EC9v+2Iq/60ApsR3/Aeo/kiNOfRyzKu
3EUUHIjUoLCzxdcTiElFxDiuCuW04dQ0kKZe2wf79vs49qkg6ADvVhNN+EGYY4jjmoGgKJPy
5WtJWI72qZbdOwoZh6L45r4ycpVy0+mr+oz2lwB5DOd03d5LiHBsBWClGRQYnKTopBdtppwz
7AKl3TMgKAG0DYIb5bmdC5KDskUqSZ9VU0LSygQjK9jlGPNwgGQ1+zrS3yZgXAJ9b7VQr9CS
QT9mfSpADbOsAghtjYGWrOb4uihBLOT+aRIvIge5mdfAWBqpJHKTWjSZpG81RWaETaDrTRQb
PVsqJs6aPutvuW2mW0qwBFooL69BM8CnIQai9md60ljTO9JY2jZALyDyDWxStdFYHCmKixPa
KostUmrrJpwg9jKCtv016nZrhYaEBRpKZl2sBOyogvDcDIqmNYhejMlumJFGLiHOkmqrrE3a
zlXrckQghixJWr2I2bLSSwC3QlcvHEHUuiZqcnYCNs8ahwMO+NkXCRaNr0tSxx+CmCc8qSSH
HyDkOjmQLlCZEqPY4CEVNudeJg4AkGOjVAI4icehD3mLKFD2VlVEdOgwEI9CaOmqIGcivc1K
w/XL1WZtisu01ICEp4+e4vYb+AVotL7c2vDVTlZYORPYailG4um16soJBuTkYmAt6+LQM6Ao
J0VCzJ3ZadTqp0VeWewPcdNggz9NGVRQNovikOwaC/EqeR5kBtXE0hBzhEaQDj8Ut/SG3ZvT
mpnGlxa5RM8a/TuJBnIgDqPeAcwjq7qPnhbqKo+ChjVJ5jzJUrCQtlIHjKZltKPJ8LaADqAY
o5y2AMPi4Wp9hXagofxN+IUexY7aA9HYEohhC5P05C4TzisRllwIpnkBwrAXexXYYl8EsJLf
APXBEkVIs6s6L1ggISyANH+VNnd4rqt9KAqFZtt4eSSKjRiEtZmXAijCtwfhYb1PEiywHVkW
zAcsUZgBtvcSrDpvvlShkK/7UZC1TutAJ2aFesKQkiutaVSvYdUIr3Fw1Qa+C9BrRVqvRwbQ
2k51ICnhzI0i14ICqBZe+tVplBrbdO7JEhoaq2DQGoCEZgKsKwCuaoKLuY3EYlpaqxWIuwp5
EkNGYgME+/Tqqo1Kh6gGONQYD/F3JFOFCQshWUaw

--ibTvN161/egqYuK8--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
